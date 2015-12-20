module Jekyll
  class ShowsByGenerator < Jekyll::Generator
    priority :normal

    def show_iterator(show)
      (@shows_by_season[show.data["season"]] ||= []) << show
      (@shows_by_period[show.data["period"]] ||= []) << show
      (@shows_by_venue[show.data["venue"]]   ||= []) << show
    end

    def generate(site)
      Jekyll.logger.info "Generating shows by..."

      # Collection hashes
      @shows_by_season = Hash.new
      @shows_by_period = Hash.new
      @shows_by_venue  = Hash.new
      @shows_by_tour   = Hash.new


      site.data["shows"].each { |show| show_iterator(show) }

      # Save generated arrays
      site.data["shows_by_season"] = @shows_by_season
      site.data["shows_by_period"] = @shows_by_period
      site.data["shows_by_venue"] = @shows_by_venue
      site.data["shows_by_tour"] = nil
    end
  end
end
