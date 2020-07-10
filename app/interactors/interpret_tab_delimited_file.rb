require 'csv'

class InterpretTabDelimitedFile
  include Interactor

  def call
    # TODO
    fail "File not exits" unless context.file && File.exists?(context.file)
    fail "Invalid file type" unless File.extname(context.file) == '.tab'

    file = File.open(context.file, 'r:utf-8', &:read)
    context.data = CSV.parse(file, col_sep: "\t", headers: true, header_converters: :symbol)
                      .map(&:to_h)
  end

  private

  def fail(message)
    context.error = message
    context.fail!
  end
end
