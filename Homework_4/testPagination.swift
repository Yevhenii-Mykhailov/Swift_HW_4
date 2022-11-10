//import UIKit
//
//class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
//    private var data = [String]()
//    var isPaginationOn = false
//    @IBOutlet weak var tableView: UITableView!

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
//        tableView.delegate = self
//        tableView.dataSource = self

//        makeRequest(isPagination: false, completion: {[weak self] response in
//            switch response{
//            case .success(let data):
//                self?.data.append(contentsOf: data)
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//            case .failure(let error):
//                break
//
//            }
//        })
//    }
//    func makeRequest(isPagination: Bool, completion: @escaping (Result<[String], Error>) -> Void){
//        if isPagination{
//            isPaginationOn = true
//        }
//        DispatchQueue.global().asyncAfter(deadline: .now() + (isPagination ? 2 : 3), execute: {
//            let data = ["Hello","You", "are","Welcome", "To", "Mobikul", "Hello","You", "are","Welcome", "To", "Mobikul","Hello","You", "are","Welcome", "To", "Mobikul","Hello","You", "are","Welcome", "To", "Mobikul",
//                        "Mobikul","Hello","You", "are","Welcome", "To", "Mobikul"]
//            let nextData = ["Enjoy", "The", "Pagination", "Blog",
//                            "Enjoy", "The", "Pagination", "Blog",
//                            "Enjoy", "The", "Pagination", "Blog"]
//            completion(.success(isPagination ? nextData : data))
//            if isPagination{
//                self.isPaginationOn = false
//            }
//        })
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pos = scrollView.contentOffset.y
//        if pos > tableView.contentSize.height-50 - scrollView.frame.size.height{
//            guard !isPaginationOn else{
//                return
//            }
//            self.makeRequest(isPagination:  true){
//                [weak self]response in
//                switch response{
//                case .success(let data):
//                    self?.data.append(contentsOf: data)
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                case .failure(let error):
//                    break
//                }
//            }
//
//        }
//    }
//
//}
//
//extension ViewController{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)as! TableViewCell
//        cell.celllabel.text = self.data[indexPath.row]
//        return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//}
