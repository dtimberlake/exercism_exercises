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
    |> handle_inline_markdown
    |> handle_block_markdown
    |> enclose_lists
  end

  defp handle_block_markdown(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&process_line(&1))
    |> Enum.join
  end

  defp process_line(line) do
    cond do
      String.starts_with?(line, "#") -> handle_header(line)
      String.starts_with?(line, "*") -> handle_list_item(line)
      :otherwise                     -> enclose_with_tag(line, "p")
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
    |> enclose_with_tag("li")
  end

  defp handle_inline_markdown(content) do
    content
    |> replace_enclosing_md("__", "strong")
    |> replace_enclosing_md("_", "em")
  end

  defp replace_enclosing_md(content, md, tag) do
    content
    |> String.replace(~r/#{md}\b/, "</#{tag}>")
    |> String.replace(md, "<#{tag}>")
  end

  defp enclose_with_tag(content, tag) do
    "<#{tag}>#{content}</#{tag}>"
  end

  defp enclose_lists(html) do
    String.replace(html, "<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
