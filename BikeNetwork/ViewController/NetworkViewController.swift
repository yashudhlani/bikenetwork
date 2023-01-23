import UIKit

class NetworkViewController: UIViewController {

    @IBOutlet weak var networkTable: UITableView!
    @IBOutlet weak var searchNetwork: UISearchBar!
    var networks: [Network] = []
    var filteredNetworks: [Network] = []
    var networkModel: BikeNetworkModelDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        if networkModel == nil {
            networkModel = BikeNetworkModel(ApiManager(), self)
        }
        
        self.networkTable.accessibilityIdentifier = "networkTable"
        self.networkTable.dataSource = self
        self.networkTable.delegate = self
        self.searchNetwork.delegate = self
        self.networkModel?.fetchNetworks()
        self.networkTable
            .register(UINib(nibName: "NetworkViewCell", bundle: nil), forCellReuseIdentifier: "networkCell")
    }
}

extension NetworkViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNetworks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.networkTable.dequeueReusableCell(withIdentifier: "networkCell") as? NetworkViewCell {
            cell.networkName.text = filteredNetworks[indexPath.row].name
            cell.companyName.text = " "
            cell.networkAddress.text =
            String("\(filteredNetworks[indexPath.row].location.city), \(networks[indexPath.row].location.country)")
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toStations", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStations" {
            if let indexPath = networkTable.indexPathForSelectedRow {
                if let stationView = segue.destination as? StationViewController {
                    stationView.networkName = networks[indexPath.row].name
                    stationView.stationsUrl = networks[indexPath.row].href
                }
            }
        }
    }
}

extension NetworkViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNetworks = searchText.isEmpty ? networks : networks.filter { network in
            network.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        networkTable.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchNetwork.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredNetworks = networks
        networkTable.reloadData()
        searchNetwork.showsCancelButton = false
        searchNetwork.text = ""
        searchNetwork.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchNetwork.showsCancelButton = false
        searchNetwork.resignFirstResponder()
    }
}

extension NetworkViewController: BikeNetworkManagerDelegate {
    func setNetwork(_ networks: [Network]) {
        DispatchQueue.main.async {
            self.networks = networks
            self.filteredNetworks = networks
            self.networkTable.reloadData()
        }
    }

    func showError(_ error: Error) {
        var errorMessage: String?
        if let error = error as? ApiError {
            errorMessage = error.errorDescription
        } else {
            errorMessage = ApiError.networkError.errorDescription
        }
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok", style: .default)
            errorAlert.addAction(okButton)
            self.present(errorAlert, animated: true)
        }
    }
}
