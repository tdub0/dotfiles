return {
  -- Grammar checker only; do not attach to code filetypes.
  filetypes = { "gitcommit", "markdown", "text", "typst" },
  on_attach = function(client)
    client.server_capabilities.completionProvider = false
  end,
  settings = {
    ["harper-ls"] = {
      linters = {
        AnA = true,
        CorrectNumberSuffix = true,
        LongSentences = false,
        Matcher = true,
        RepeatedWords = true,
        SentenceCapitalization = false,
        Spaces = true,
        SpellCheck = false,
        SpelledNumbers = false,
        SplitWords = false,
        UnclosedQuotes = true,
        WrongQuotes = false,
      },
    },
  },
}
