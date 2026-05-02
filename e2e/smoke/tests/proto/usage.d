import addressbook;

unittest
{
    auto person = new Person();
    person.name = "Ada";

    assert(person.name == "Ada");
}
