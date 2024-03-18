# frozen_string_literal: true

module GraphQLHelpers
  def controller
    @controller ||= GraphqlController.new.tap do |obj|
      obj.set_request! ActionDispatch::Request.new({})
    end
  end

  def execute_graphql(query, **kwargs)
    AccompanistConnectionApiSchema.execute(
      query,
      context: { controller: }, **kwargs
    )
  end
end

RSpec.configure do |c|
  c.include GraphQLHelpers, type: :graphql
end
