import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Bool "mo:base/Bool";

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
