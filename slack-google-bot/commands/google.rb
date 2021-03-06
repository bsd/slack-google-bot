module SlackGoogleBot
  module Commands
    class Google < SlackRubyBot::Commands::Base
      match(/^(?<bot>\w*)\s(?<expression>.*)$/) do |client, data, match|
        expression = match['expression'].strip
        query = { query: expression }
        query[:cx] = ENV['GOOGLE_CSE_ID'] if ENV['GOOGLE_CSE_ID']
        result = ::Google::Search::Web.new(query).first
        message = result ? result.title + "\n" + result.uri : "Hmm, I'm not sure. I don't know everything human <@seth> knows."
        send_message client, data.channel, message

      end
    end
  end
end
