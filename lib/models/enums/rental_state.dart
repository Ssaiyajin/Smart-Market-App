enum RentalState { requested, accepted, declined }

RentalState parseRentalState(String toParse) {
  return RentalState.values.byName(toParse.toLowerCase());
}
