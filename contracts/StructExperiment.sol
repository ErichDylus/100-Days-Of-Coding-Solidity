pragma solidity ^0.5.3;
pragma experimental ABIEncoderV2;

contract storageContract {

  event Inserted(address _sender, address _recordId);
  event Updated(address _sender, address _recordId);
  event Deleted(address _sender, address _recordId);

  struct Data {
    string text;
  }
  struct Record {
    Data data;
    uint idListPointer;
  }

  mapping(address => Record) public Table;
  address[] public IdList;

  constructor() public {}

  // Check if recordId is in IdList, it's common for the record to be deleted and not by in the IdList anymore
  function Exists(address recordId) public view returns(bool exists) {
    if (IdList.length == 0) return false;
    return (IdList[Table[recordId].idListPointer] == recordId);
  }

  function GetLength() public view returns(uint count) {
    return IdList.length;
  }

  function GetByIndex(uint recordIndex) public view returns(address recordId, Data memory record) {
    require(recordIndex < IdList.length);
    return (IdList[recordIndex], Table[IdList[recordIndex]].data);
  }

  function GetById(address recordId) public view returns(uint index, Data memory record) {
    require(Exists(recordId));
    return (Table[recordId].idListPointer, Table[recordId].data);
  }

  function Insert(Data memory recordData) public returns(bool success) {
    address recordAddress = address(now);
    require(!Exists(recordAddress));
    Table[recordAddress].data = recordData;
    Table[recordAddress].idListPointer = IdList.push(recordAddress) - 1;
    emit Inserted(msg.sender, recordAddress);
    return true;
  }

  function Update(address recordId, Data memory recordData) public returns(bool success) {
    require(Exists(recordId));
    Table[recordId].data = recordData;
    emit Updated(msg.sender, recordId);
    return true;
  }

  // once a record has been deleted from the idList it can no longer be modified, but the memory remains
  // You can still pull deleted records if you hit the Table object directly, you will not be able to use GetByIndex or GetById
  function Delete(address recordId) public returns(bool success) {
    require(Exists(recordId));
    // get the record id to delete
    uint recordToDelete = Table[recordId].idListPointer;
    // set the last item in the id list to keep and move
    address keyToMove = IdList[IdList.length - 1];
    // replace the id of the deleted record with the one we want to keep i.e the last item
    IdList[recordToDelete] = keyToMove;
    // update the last record in the list to point to it's new position in the key list which is the old deleted records spot
    Table[keyToMove].idListPointer = recordToDelete;
    // remove the last element from the id list that holds the old pointer for the keep record
    IdList.length--;
    // emit event
    emit Deleted(msg.sender, recordId);
    return true;
  }

}
