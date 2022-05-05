import Foundation


protocol ViewModelProtocol {
    
    var delegate: ViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    func load()
    func user(index: Int) -> UserList?

}

protocol ViewModelDelegate: AnyObject {
    func reloadData()
}

final class ViewModel {
    
    private var users : [UserList] = []
    let service = UserListRequest()
    weak var delegate: ViewModelDelegate?
    
    
    fileprivate func fetchUsers() {
        service.getUsers{ [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let users):
                self.users = users
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }

    }
}

extension ViewModel: ViewModelProtocol {
    
    var numberOfItems: Int {
        users.count
    }

    func load() {
        fetchUsers()
    }
    
    func user(index: Int) -> UserList? {
        users[index]
    }
    
    
}
