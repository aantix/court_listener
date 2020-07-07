require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module CourtListener
  class Search
    BASE_URL     = "https://www.courtlistener.com/api/rest/v3/search/?"

    STATE_COURTS = {
        "alabama" => "ala alactapp alacrimapp alacivapp",
        "alaska" => "alaska alaskactapp",
        "arizona" => "ariz arizctapp ariztaxct",
        "arkansas" => "ark arkctapp arkworkcompcom arkag",
        "california" => "cal calctapp calappdeptsuper calag",
        "colorado" => "colo coloctapp coloworkcompcom coloag",
        "connecticut" => "conn connappct connsuperct connworkcompcom",
        "delaware" => "del delch delsuperct delctcompl delfamct deljudct dc",
        "florida" => "fla fladistctapp flaag",
        "georgia" => "ga gactapp",
        "hawaii" => "haw hawapp",
        "idaho" => "idaho idahoctapp",
        "illinois" => "ill illappct",
        "indiana" => "ind indctapp indtc",
        "iowa" => "iowa iowactapp",
        "kansas" => "kan kanctapp kanag",
        "kentucky" => "ky kyctapp kyctapphigh",
        "louisiana" => "la lactapp laag",
        "maine" => "me",
        "maryland" => "md mdctspecapp mdag",
        "massachusetts" => "mass massappct masssuperct massdistct maworkcompcom",
        "michigan" => "mich michctapp",
        "minnesota" => "minn minnctapp minnag",
        "mississippi" => "miss missctapp",
        "missouri" => "mo moctapp moag",
        "montana" => "mont monttc montag",
        "nebraska" => "neb nebctapp nebag",
        "nevada" => "nev",
        "new-hampshire" => "nh",
        "new-jersey" => "nj njsuperctappdiv njtaxct njch",
        "new-mexico" => "nm nmctapp",
        "new-york" => "ny nyappdiv nyappterm nysupct nyfamct nysurct nycivct nycrimct nyag",
        "north-carolina" => "nc ncctapp ncsuperct ncworkcompcom",
        "north-dakota" => "nd ndctapp",
        "ohio" => "ohio ohioctapp ohioctcl",
        "oklahoma" => "okla oklacivapp oklacrimapp oklajeap oklacoj oklaag",
        "oregon" => "or orctapp ortc",
        "pennsylvania" => "pa pasuperct pacommwct cjdpa",
        "rhode-island" => "ri risuperct",
        "south-carolina" => "sc scctapp",
        "south-dakota" => "sd",
        "tennessee" => "tenn tennctapp tenncrimapp tennworkcompcl tennworkcompapp tennsuperct",
        "texas" => "tex texapp texcrimapp texreview texjpml texag",
        "utah" => "utah utahctapp",
        "vermont" => "vt vtsuperct",
        "virginia" => "va vactapp",
        "washington" => "wash washctapp washag",
        "west Virginia" => "wva",
        "wisconsin" => "wis wisctapp wisag",
        "wyoming" => "wyo"
    }

    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def search(params = {})
      request(params)
    end

    def self.jurisdictions_for(state:)
      return nil if state.nil?

      STATE_COURTS[state.downcase.gsub(' ', '-')]
    end

    private
    def request(params)
      url  = URI("#{BASE_URL}#{URI.encode_www_form(params)}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Token #{api_key}"

      response = http.request(request)
      return JSON.parse(response.read_body)
    end
  end
end
