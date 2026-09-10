-- Prose only
-- Skip code filetypes so harper does not sit on Python or C
return {
  filetypes = { "gitcommit", "markdown", "text", "typst" },
  on_attach = function(client)
    client.server_capabilities.completionProvider = false
  end,
  settings = {
    ["harper-ls"] = {
      linters = {
        AnA = true,
        CorrectNumberSuffix = true,
        ExpandConfiguration = false,
        ExpandCoordinate = false,
        LongSentences = false,
        Matcher = true,
        NumericRangeEnDash = false,
        OrthographicConsistency = false,
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
