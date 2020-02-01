module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def check_authentication!
      return if context[:current_user]

      raise GraphQL::ExecutionError.new(I18n.t('errors.unauthenticated'), extensions: { code: 'AUTHENTICATION_ERROR' })
    end

    def validation_errors!(object)
      object.errors.map do |attr, message|
        message = object[attr] + ' ' + message if object[attr].present?
        context.add_error(GraphQL::ExecutionError.new(message, extensions: { code: 'INPUT_ERROR', attribute: attr }))
      end
      return
    end
  end
end
