Puppet::Type.type(:ravendb_database).provide(:ruby) do
    confine :feature => :ravendbapiclient
    
    def initialize(value={})
        super(value)
        require "ravendb/api/client"
    end

    def exists?
        Ravendb::Api::Client.new(url: 'http://localhost:8080').database_exists?(name: resource[:name])
    end

    def create
    end

    def destroy
    end
end