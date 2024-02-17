import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Bool "mo:base/Bool";

actor Assistant {

  type Person = {
    namesurname : Text;
    birthDate : Text;
    nationality : Text;
  };

  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
};
