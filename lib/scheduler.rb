class Scheduler

  def self.get_shows
    conn = Faraday::Connection.new 'https://goldstar-remote-api.com'
    response = conn.get ''
    api_shows = JSON.parse(response.body)

    local_shows = Show.all

    seconds_in_hour = 3600
    min_span_in_seconds = 15
    shows_to_update = {}

    local_shows.each do |local_show|
      seconds_until_next_update = 0
      api_shows.each do |api_show|

        if local_show[:id] == api_show["id"]
          seconds_until_next_update = (shows_to_update.size + 1) * min_span_in_seconds - min_span_in_seconds

          if (local_show[:last_update].nil? || (api_show["quantity"] != local_show[:quantity] && local_show[:last_update] >= seconds_in_hour))
            id = local_show[:id]
            shows_to_update[id] = seconds_until_next_update
          end

        end
      end
    end

    return shows_to_update
  end
end
