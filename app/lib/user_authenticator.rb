class UserAuthenticator
    class AuthenticationError < StandardError; end

    attr_reader :user

    def initialize(code)
        @code = code
    end

    def perform
        client = Octokit::Client.new(
            client_id: ENV['GITHUB_CLIENT_ID'],
            client_secret: ENV['GITHUB_CLIENT_SECRET']
        )
        token = client.exchange_code_for_token(code)
        if token.try(:error).present?
            raise AuthenticationError        
        else
            user_client = Octokit::Client.new(:access_token => token)
            user_data = user_client.user.to_h.slice(:login, :avatar_url, :url, :name)
            User.create(user_data.merge(provider: 'github'))
        end
    end

    private

    attr_reader :code
end


# client = Octokit::Client.new(client_id: 'e37f7935ba4983e80da2', client_se
#     cret: 'fe78d02450d4c6f0bf60e9841f86da21004d9839')