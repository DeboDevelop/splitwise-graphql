class Types::SharedAmoungInputType < GraphQL::Schema::InputObject
    graphql_name "SharedAmoungInputType"
    description "Attributes for percentage and unequal split bill"

    argument :id, Int, "Id of the user", required: true
    argument :amount, Float, "Amount/percentage of bill shared by the user", required: true

    def self.visible?(context)
        !!context[:current_user]
    end
end