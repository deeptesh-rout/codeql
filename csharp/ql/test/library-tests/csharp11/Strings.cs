using System;

public class MyTestClass
{
    public string M1(int x)
    {
        // Use an expression that spans across multiple lines in a string interpolation.
        return $"This is my int {x switch
        {
            42 => "forty two",
            _ => "something else"
        }}.";
    }

    public void M2()
    {
        // Raw string literal.
        var message1 = """
        This is my very long
            text message that spans
          accross multiple lines
        and is very useful.
        """;

        // String interpolation using a raw string literal.
        var message2 = $"""
        The nested message
          is "{message1}" and everything
        spans multiple lines.
        """;

        // String interpolation using a raw string literal that requires double curly braces.
        var message3 = $$"""
        Show no curly braces: {{message1}}
        Show matching set of curly braces: {{{message2}}}
        """;
    }
}