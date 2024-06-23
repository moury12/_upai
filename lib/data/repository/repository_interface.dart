
abstract class RepositoryInterface {


  Future<List<dynamic>> returnData();

  Future<dynamic> login(String userName, String password);

  Future<dynamic> register(String userName, String email, String password);

  Future<dynamic> updateProfile(String firstName, String lastName);
}
