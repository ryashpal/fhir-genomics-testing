module InfernoTemplate
  class RiskAssessmentGroup < Inferno::TestGroup
    title 'RiskAssessment Tests'
    description 'Verify that the server makes RiskAssessment resources available'
    id :risk_assessment_group

    test do
      title 'Server returns requested RiskAssessment resource from the RiskAssessment read interaction'
      description %(
        Verify that RiskAssessment resources can be read from the server.
      )

      input :risk_assessment_id,
            title: 'RiskAssessment ID'

      # Named requests can be used by other tests
      makes_request :risk_assessment

      run do
        fhir_read(:risk_assessment, risk_assessment_id, name: :risk_assessment)

        assert_response_status(200)
        assert_resource_type(:risk_assessment)
        assert resource.id == risk_assessment_id,
               "Requested resource with id #{risk_assessment_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'RiskAssessment resource is valid'
      description %(
        Verify that the RiskAssessment resource returned from the server is a valid FHIR resource.
      )
      # This test will use the response from the :risk_assessment request in the
      # previous test
      uses_request :risk_assessment

      run do
        assert_resource_type(:risk_assessment)
        assert_valid_resource
      end
    end

  end
end
