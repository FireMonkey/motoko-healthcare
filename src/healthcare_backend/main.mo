import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Bool "mo:base/Bool";
import Array "mo:base/Array";

actor Assistant {

  type Person = {
    personId : Nat;
    nameSurname : Text;
    birthDate : Text;
    nationality : Text;
  };

  type DiseaseHistory = {
    personId : Nat;
    date : Text;
    description : Text;
    image : Text;
    isHealed : Bool;
  };

  func natHash(n : Nat) : Hash.Hash {
    Text.hash(Nat.toText(n));
  };

  var persons = Map.HashMap<Nat, Person>(0, Nat.equal, natHash);
  var diseaseHistories = Map.HashMap<Nat, DiseaseHistory>(0, Nat.equal, natHash);

  var nextPersonId : Nat = 0;
  var nextDiseaseHistoryId : Nat = 0;

  public query func getPersons() : async [Person] {
    return Iter.toArray(persons.vals());
  };

  public func addToPerson(nameSurname : Text, nationality : Text, birthDate : Text) : async Nat {
    let id = nextPersonId;
    persons.put(
      id,
      {
        personId = id;
        nameSurname = nameSurname;
        nationality = nationality;
        birthDate = birthDate;
      },
    );
    nextPersonId += 1;
    return id;
  };

  public query func getDiseaseHistories(personId : Nat) : async [DiseaseHistory] {
    // Assuming diseaseHistories is a collection that supports .vals() yielding DiseaseHistory
    // and DiseaseHistory has a field personId of type Nat.

    // Convert the values to an array first if you want to work with an array,
    // but for filtering, you can directly use Iter.filter on the iterator.
    let histories = diseaseHistories.vals(); // Getting an iterator over the values

    // Use Iter.filter to directly filter the histories based on personId
    let filteredHistories = Iter.toArray(
      Iter.filter(
        histories,
        func(history : DiseaseHistory) : Bool {
          history.personId == personId;
        },
      )
    );

    return filteredHistories;
  };

  // public query func getDiseaseHistories(personId : Nat) : async [DiseaseHistory] {
  //   // let historyArray = Iter.toArray(diseaseHistories.vals());
  //   // return Iter.filter(
  //   //   historyArray,
  //   //   func(history : DiseaseHistory) : Bool {
  //   //     history.personId == personId;
  //   //   },
  //   // );
  //   // return Iter.filter(
  //   //   historyArray,
  //   //   func(history : DiseaseHistory) : Bool {
  //   //     history.personId == personId;
  //   //   },
  //   // );
  //   var emptyHistoryArray : [DiseaseHistory] = [];

  //   // var array : [DiseaseHistory] = Array.init<DiseaseHistory>(4, null);

  //   // let array = Array.init<Nat>(4, 2);
  //   // type List<DiseaseHistory> var resultList = <DiseaseHistory>(0, Nat.equal, natHash);
  //   for (history : DiseaseHistory in diseaseHistories.vals()) {
  //     if (history.personId == personId) {
  //       emptyHistoryArray := emptyHistoryArray # [history];
  //     };
  //   };
  //   return array;

  // };

  // public query func getDiseaseHistories(personId : Nat) : async [DiseaseHistory] {
  //   // var list = Iter.toArray(diseaseHistories.vals());
  // };

  // private query func GetDiFilter(list : [DiseaseHistory], personId : Nat) : async [DiseaseHistory] {
  //   return Iter.filter(
  //     list,
  //     func(history : DiseaseHistory) : Bool {
  //       history.personId == personId;
  //     },
  //   );
  // };

  public func addToDiseaseHistories(personId : Nat, date : Text, description : Text, image : Text, isHealed : Bool) : async Nat {
    let id = nextDiseaseHistoryId;
    diseaseHistories.put(id, { personId = personId; date = date; description = description; image = image; isHealed = isHealed });
    nextDiseaseHistoryId += 1;
    return id;
  };
};
