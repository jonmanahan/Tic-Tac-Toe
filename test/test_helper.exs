ExUnit.start()

"./test/mocks/"
|> Path.join("*.ex")
|> Path.wildcard()
|> Enum.map(&Code.require_file/1)

"./test/test_helpers/"
|> Path.join("*.ex")
|> Path.wildcard()
|> Enum.map(&Code.require_file/1)
