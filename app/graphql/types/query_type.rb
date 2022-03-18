module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
 
    field :current_user, Types::UserType, null: true, description: "The currently logged in user"

    def current_user
      context[:current_user]
    end

    field :friendship, [Types::UserType], null: true, description: "Get friendship of current user"

    def friendship
      user_friend = Friendship.where(user_id: context[:current_user].id).map{ |friend| User.find(friend.friend_user_id)}
      friend_user = Friendship.where(friend_user_id: context[:current_user].id).map{ |friend| User.find(friend.user_id)}
      byebug
      user_friend + friend_user
    end
  end
end
