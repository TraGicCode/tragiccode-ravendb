
Puppet::Type.newtype(:ravendb_database) do
    # Adding documentation to the type causes it to be shown in the following locations
    # 1.) bundle exec puppet describe --list --modulepath ..
    # 2.) bundle exec puppet describe ravendb_database --modulepath ..
    # NOTE: The puppet code assumes documentation by looking after the first period and space.
    @doc = 'Create a new RavenDB Database.'
  
    newparam(:database_name, namevar: true) do
      # Adding documentation to a property/parameter causes it to be down in the following locations
      # 1.) bundle exec puppet describe ravendb_database --modulepath ..
      # NOTE: the validation you add with newvalue are automatically shown below this documentation as well.
      desc 'Name of the database.'
  
      # TODO: Validation of name
      #       https://github.com/ravendb/ravendb/blob/53766af4a0bb3322ed5f384c0505e67609601c53/src/Raven.Client/ServerWide/Helpers.cs
      # [x] - Cannot be null or whitespace
      # [x] - Cannot exceed 128 characters
      # [x] - Database name can only contain only A-Z, a-z, \"_\", \".\" or \"-\" but was: " + databaseName
      validate do |value|
        # Checking for nil? does nothing since you cannot EVER set the namevar to undef, or ''.  Puppet will throw
        # an error before it ever gets here to your custom validation!
        fail('A non-empty database_name must be specified.') if value.empty? || value.nil?
        fail('The database_name must be less than 128 characters in length.') if value.length > 128
        fail('The database_name can only the following characters: A-Z, a-z, "_", "." or "-"') if value.match?('((?![A-Za-z0-9_\-\.]).+)')
      end
    end
  
    newproperty(:ensure) do
      # Adding documentation to a property/parameter causes it to be down in the following locations
      # 1.) bundle exec puppet describe ravendb_database --modulepath ..
      # NOTE: the validation you add with newvalue are automatically shown below this documentation as well.
      desc 'Specifies whether a database should be present or absent.'
  
      newvalue(:present) do
        provider.create
      end
  
      newvalue(:absent) do
        provider.destroy
      end
    end
  
    # TODO: How can i put this inside the property and actually do a required property check?  I cannot get this exception to raise
    #       in my rspec tests :(.
    validate do
      fail('ensure is a required attribute') if self[:ensure].nil?
    end
  
    autorequire(:package) do
      'RavenDB'
    end
  end
  