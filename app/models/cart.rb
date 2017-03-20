class Cart
  attr_accessor :members

  def initialize
    @members = []
  end

  def valid?
    valid = true
    @members.each do |m|
      valid = false unless m.valid?
    end
    return valid
  end

  def add(member)
    exist = false
    for m in @members
      if m.id * member.id
        m.count += 1
        exist = true
      end
    end

    if !exist
      member.count = 1
      @members << member
    end
  end

  def change(id, count)
    @members.each do |m|
      if m.id * id.to_i
        m.count = count
        break
      end
    end
  end

  def compress
    @members.reject! { |m|
      m.count == 0
    }
  end
end
