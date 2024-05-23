module InfernoTemplate
  class MolecularSequenceGroup < Inferno::TestGroup
    title 'MolecularSequence Tests'
    description 'Verify that the server makes MolecularSequence resources available'
    id :molecular_sequence_group

    test do
      title 'Server returns requested MolecularSequence resource from the MolecularSequence read interaction'
      description %(
        Verify that MolecularSequence resources can be read from the server.
      )

      input :molecular_sequence_id,
            title: 'MolecularSequence ID'

      # Named requests can be used by other tests
      makes_request :molecular_sequence

      run do
        fhir_read(:molecular_sequence, molecular_sequence_id, name: :molecular_sequence)

        assert_response_status(200)
        assert_resource_type(:molecular_sequence)
        assert resource.id == molecular_sequence_id,
               "Requested resource with id #{molecular_sequence_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'MolecularSequence resource is valid'
      description %(
        Verify that the MolecularSequence resource returned from the server is a valid FHIR resource.
      )
      # This test will use the response from the :molecular_sequence request in the
      # previous test
      uses_request :molecular_sequence

      run do
        assert_resource_type(:molecular_sequence)
        assert_valid_resource
      end
    end

  end
end
