# encoding: utf-8

module NotesHelper

  def ugly_lyrics(lyrics)
    ugly = lyrics.split("  ")
    formatted = ugly.map do |line|
      "♫ " + line
    end
    formatted = formatted.join("\n")

    <<-HTML.html_safe
    <pre>#{h(formatted)}</pre>
    HTML
  end
end
