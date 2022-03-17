ExUnit.start()

"./test/mocks/"
|> Path.join("*.ex")
|> Path.wildcard()
|> Enum.map(&Code.require_file/1)
