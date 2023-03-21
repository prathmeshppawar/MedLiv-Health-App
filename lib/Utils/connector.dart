import 'package:fluttertoast/fluttertoast.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class Connector {
  static late EthereumAddress address;
  static late String key;
  static late String role;
  static String blockchainUrl =
      "https://goerli.infura.io/v3/10bdad47176b4851a0e7a9583c6ea60c";

  static Client httpClient = Client();
  static Web3Client ethClient = Web3Client(blockchainUrl, httpClient);

  static Future<DeployedContract> getContractPatient() async {
    String abiFilePatient =
        await rootBundle.loadString("assets/contracts/patient.json");
    String contractAddress = "0x372675be07003210b946d1ebf37c40fef97853b1";
    final contractPatient = DeployedContract(
        ContractAbi.fromJson(abiFilePatient, "Patient"),
        EthereumAddress.fromHex(contractAddress));

    return contractPatient;
  }

  static Future<DeployedContract> getContractDoctor() async {
    String abiFileDoctor =
        await rootBundle.loadString("assets/contracts/doctor.json");
    String contractAddress = "0x92fb14cc22ad101a5dcde4ee0ebe7192e34edb2b";
    final contractDoctor = DeployedContract(
        ContractAbi.fromJson(abiFileDoctor, "Doctor"),
        EthereumAddress.fromHex(contractAddress));
    return contractDoctor;
  }

  static Future<bool> isDoctorExists(EthereumAddress address) async {
    final contract = await getContractDoctor();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("isDoctor"),
        params: [address]);
    return result[0];
  }

  static Future<bool> isPatientExists(EthereumAddress address) async {
    final contract = await getContractPatient();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("isPatient"),
        params: [address]);
    return result[0];
  }

  static Future<String> getFee(EthereumAddress address) async {
    final contract = await getContractDoctor();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("getFee"),
        params: [address]);
    return result[0].toString();
  }

  static Future<bool> isAuthorized(
      EthereumAddress doc, EthereumAddress pat) async {
    final contract = await getContractPatient();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("isAuthorized"),
        params: [doc, pat]);
    return result[0];
  }

  static Future<dynamic> getPresc(EthereumAddress address) async {
    final contract = await getContractPatient();
    final result = await ethClient.call(
        contract: contract,
        function: contract.function("viewPrescription"),
        params: [address]);
    return result[0];
  }

  static Future<bool> logInDoctor(String address, String privateKey) async {
    EthereumAddress addr = EthereumAddress.fromHex(address);
    bool result = await isDoctorExists(addr);
    if (result == true) return true;
    Credentials key = EthPrivateKey.fromHex(privateKey);

    //obtain our contract from abi in json file
    final contract = await getContractDoctor();

    // extract function from json file
    final function = contract.function("addDoctor");

    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
      key,
      Transaction.callContract(
          contract: contract, function: function, parameters: [addr]),
      chainId: 5,
    );
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isDoctorExists(addr);
    return result;
  }

  static Future<bool> logInPatient(String address, String privateKey) async {
    // print("here2");
    EthereumAddress addr = EthereumAddress.fromHex(address);
    bool result = await isPatientExists(addr);
    // print("here3");
    if (result == true) return true;
    Credentials key = EthPrivateKey.fromHex(privateKey);
    // print("here4");
    //obtain our contract from abi in json file
    final contract = await getContractPatient();

    // extract function from json file
    final function = contract.function("addPatient");

    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
      key,
      Transaction.callContract(
          contract: contract, function: function, parameters: [addr]),
      chainId: 5,
    );
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isPatientExists(addr);
    return result;
  }

  static Future<String> updateDoctorFee(
      EthereumAddress address, String privateKey, String amount) async {
    Credentials key = EthPrivateKey.fromHex(privateKey);

    //obtain our contract from abi in json file
    final contract = await getContractDoctor();

    // extract function from json file
    final function = contract.function("updateFee");

    //send transaction using the our private key, function and contract
    // print("here2");
    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            contract: contract,
            function: function,
            parameters: [address, BigInt.parse(amount)]),
        chainId: 5);
    // print("here3");
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    // print("here4");
    String result = await getFee(address);
    return result;
  }

  static Future<bool> addAuthorization(
      EthereumAddress doc, EthereumAddress pat, String privateKey) async {
    bool result = await isAuthorized(doc, pat);
    if (result) return true;
    String fee = await getFee(doc);

    Credentials key = EthPrivateKey.fromHex(privateKey);

    //obtain our contract from abi in json file
    final contract = await getContractPatient();

    // extract function from json file
    final function = contract.function("addAuthorization");

    //send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            // ignore: deprecated_member_use
            value: EtherAmount.fromUnitAndValue(EtherUnit.wei, fee),
            contract: contract,
            function: function,
            parameters: [doc, pat, BigInt.parse(fee)]),
        chainId: 5);
    //set a 40 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    await Future.delayed(const Duration(seconds: 40), () {});
    result = await isAuthorized(doc, pat);
    return result;
  }

  static Future<void> setPresc(EthereumAddress doc, EthereumAddress pat,
      String privateKey, String prescription) async {
    if (await isAuthorized(doc, pat)) {
      Credentials key = EthPrivateKey.fromHex(privateKey);

      //obtain our contract from abi in json file
      final contract = await getContractPatient();

      // extract function from json file
      final function = contract.function("setPrescription");

      //send transaction using the our private key, function and contract
      await ethClient.sendTransaction(
          key,
          Transaction.callContract(
              contract: contract,
              function: function,
              parameters: [prescription, pat, doc]),
          chainId: 5);
    } else {
      Fluttertoast.showToast(msg: "You are not authorized");
    }
  }
}
