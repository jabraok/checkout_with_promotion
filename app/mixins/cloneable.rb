module Cloneable
  def clone
    clone_object(object)
  end

  def clone_object(object)
    Marshal.load(Marshal.dump(object))
  end
end