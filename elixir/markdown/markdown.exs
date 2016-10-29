defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&process(&1))
    |> Enum.join
    |> patch
  end

  defp process(line) do
    cond do
      String.starts_with?(line, "#") -> handle_header(line)
      String.starts_with?(line, "*") -> handle_list_item(line)
      :otherwise                     -> handle_paragraph(line)
    end
  end

  defp handle_header(line) do
    [header, content] = String.split(line, " ", parts: 2)
    tag = "h#{String.length(header)}"
    enclose_with_tag(content, tag)
  end

  defp handle_list_item(line) do
    line
    |> String.trim_leading("* ")
    |> handle_inner_markdown
    |> enclose_with_tag("li")
  end

  defp handle_paragraph(line) do
    line
    |> handle_inner_markdown
    |> enclose_with_tag("p")
  end

  defp handle_inner_markdown(content) do
    content
    |> replace_enclosing_md("__", "strong")
    |> replace_enclosing_md("_", "em")
  end

  defp replace_enclosing_md(content, md, tag) do
    regex = "#{md}(.*)#{md}" |> Regex.compile!
    case Regex.run(regex, content) do
      [match, inner_match] -> replace_inner_match(content, match, inner_match, tag)
      nil                  -> content
    end
  end

  defp replace_inner_match(content, match, inner_match, tag) do
    inner_content = inner_match |> enclose_with_tag(tag)
    String.replace(content, match, inner_content)
  end

  defp enclose_with_tag(content, tag) do
    "<#{tag}>#{content}</#{tag}>"
  end

  defp patch(html) do
    String.replace(html, "<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
