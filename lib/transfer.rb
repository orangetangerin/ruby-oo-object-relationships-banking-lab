class Transfer

  attr_accessor :status
  attr_reader :amount, :sender, :receiver

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.valid? && self.sender.balance > self.amount && self.status == "pending"
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      self.reject
    end
  end

  def reverse_transfer
    if self.valid? && self.receiver.balance > self.amount && self.status == "complete"
      sender.balance += amount
      receiver.balance -= amount
      self.status = "reversed"
    else
      self.reject
    end
  end

  def reject
    self.status = "rejected"
    return "Transaction rejected. Please check your account balance."
  end

end
