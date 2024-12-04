actor Main
  new create(env: Env) =>
    let user = User.create("Alice", 42)
    env.out.print("Hello, " + user.name + "!\n")

    let user2 = User("Bob", 40)
    env.out.print("Hello, " + user2.name + "!")
    env.out.print("You are " + user2.age().string() + " old")
    user2.ageUp()
    env.out.print("Next year you'll be " + user2.age().string() + " old\n")

    env.out.print("Next year, your ages together will be " + CoolStuff.countAges(user.age(), user2.age()).string() + "\n")

    let kid = User.kid("Bob")
    env.out.print("Hello, Little " + kid.name + "!\n")
    while kid.age() < 18 do
      kid.ageUp()
      env.out.print("Little bobs is now " + kid.age().string() + " years old!")

      if kid.is_a_kid() == false then
        env.out.print("Little Bob is now an adult!\n")
      end
    end

    env.out.print("Hello, " + "World" + "!\n")


class User
  let name: String
  var _age: U32
  var is_kid: Bool = false

  new create(name': String, age': U32) =>
    name = name'
    _age = age'

  new kid(name': String) =>
    name = name'
    _age = 7
    is_kid = true

  fun age(): U32 => _age

  fun is_a_kid(): Bool => is_kid

  fun ref ageUp() =>
    _age = _age + 1
    if (is_kid) and (_age >= 18) then
      is_kid = false
    end

primitive CoolStuff
  fun countAges(a: U32, b: U32): U32 =>
    a + b