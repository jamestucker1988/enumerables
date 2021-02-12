require_relative '../main'

describe Enumerable do
  enumerable = [1, 2, 3]
  enumerable2 = (1..3)
  enumerable3 = { 'a' => 2, 'b' => 3, 'c' => 4 }
  describe '#my_each' do
    it 'returns twice the value of each element' do
      arr = []
      enumerable.my_each { |el| arr << el * 2 }
      expect(arr).to eq([2, 4, 6])
    end

    it 'returns thrice the value of each element' do
      range = []
      enumerable2.my_each { |el| range << el * 3 }
      expect(range).to eq([3, 6, 9])
    end

    it 'returns each element being added by five' do
      hash = []
      enumerable3.my_each { |_el, value| hash << value + 5 }
      expect(hash).to eq([7, 8, 9])
    end
  end

  describe '#my_each_with_index' do
    it 'returns each element with its index, with the value multiplied by four.' do
      arr = []
      enumerable.my_each_with_index { |el, _value| arr << el * 4 }
      expect(arr).to eq([4, 8, 12])
    end

    it 'returns each element with its index, with the index subtracted by one.' do
      arr = []
      enumerable.my_each_with_index { |_el, value| arr << value - 1 }
      expect(arr).to eq([-1, 0, 1])
    end

    it 'returns each element with its index, with the value exponentiated by two.' do
      range = []
      enumerable2.my_each_with_index { |el, _value| range << el**2 }
      expect(range).to eq([1, 4, 9])
    end

    it 'returns each element with its index, with the index added by two.' do
      range = []
      enumerable2.my_each_with_index { |_el, value| range << value + 2 }
      expect(range).to eq([2, 3, 4])
    end

    it 'returns each element with its index, with the value multiplied by three.' do
      hash = []
      enumerable3.my_each_with_index { |_el, value| hash << value * 3 }
      expect(hash).to eq([6, 9, 12])
    end

    it 'returns each element with its index, with the index divided by one.' do
      hash = []
      enumerable3.my_each_with_index { |_el, value| hash << value / 1 }
      expect(hash).to eq([2, 3, 4])
    end
  end

  describe '#my_select' do
    it 'returns each element that is divisible by two.' do
      arr = []
      enumerable.my_select { |el| arr << el if el.even? }
      expect(arr).to eq([2])
    end

    it 'returns each element that is an odd number.' do
      range = []
      enumerable2.my_select { |el| range << el if el.odd? }
      expect(range).to eq([1, 3])
    end
  end

  describe '#my_map' do
    it 'returns each element multiplied by itself.' do
      arr = []
      enumerable.my_map { |el| arr << el * el }
      expect(arr).to eq([1, 4, 9])
    end

    it 'returns each element in string form.' do
      range = []
      enumerable2.my_map { |el| range << el.to_s }
      expect(range).to eq(%w[1 2 3])
    end

    it 'returns each element in symbol form.' do
      hash = []
      enumerable3.my_map { |el, _value| hash << el.to_sym }
      expect(hash).to eq(%i[a b c])
    end
  end

  describe '#my_all?' do
    it 'checks if the elements are lesser than 5.' do
      flag = enumerable.my_all? { |el| el < 5 }
      expect(flag).to eq(true)
    end

    it 'checks if the elements are greater than 2.' do
      flag = enumerable.my_all? { |el| el > 2 }
      expect(flag).to eq(false)
    end

    it 'checks if all elements are numerics.' do
      flag = enumerable2.my_all? { |el| el.class.superclass == Numeric }
      expect(flag).to eq(true)
    end

    it 'checks if all elements are not numerics.' do
      flag = enumerable.my_all? { |el| el.class.superclass != Numeric }
      expect(flag).to eq(false)
    end

    it 'checks if all elements are integers.' do
      flag = enumerable.my_all? { |el| el.instance_of?(Integer) }
      expect(flag).to eq(true)
    end

    it 'checks if all elements are not integers.' do
      flag = enumerable.my_all? { |el| el.class != Integer }
      expect(flag).to eq(false)
    end
  end

  describe '#my_any?' do
    it 'checks if any elements are even.' do
      flag = enumerable.my_any?(&:even?)
      expect(flag).to eq(true)
    end

    it 'checks if any elements are odd.' do
      flag = enumerable.my_any?(&:odd?)
      expect(flag).to eq(true)
    end

    it 'checks if the elements are lesser than 3.' do
      flag = enumerable2.my_any? { |el| el < 3 }
      expect(flag).to eq(true)
    end

    it 'checks if the elements are greater than 10.' do
      flag = enumerable2.my_all? { |el| el > 10 }
      expect(flag).to eq(false)
    end

    it 'checks if any elements are string type.' do
      flag = enumerable3.my_any? { |el, _value| el.instance_of?(String) }
      expect(flag).to eq(true)
    end

    it "checks if any element's values are string type." do
      flag = enumerable3.my_any? { |_el, value| value.instance_of?(String) }
      expect(flag).to eq(false)
    end
  end

  describe '#my_none?' do
    it 'checks if any elements are greater than 10.' do
      flag = enumerable.my_none? { |el| el > 10 }
      expect(flag).to eq(true)
    end

    it 'checks if any elements are of the nil type.' do
      flag = enumerable2.my_none?(&:nil?)
      expect(flag).to eq(true)
    end

    it "checks if any element's values are lesser than 3." do
      flag = enumerable2.my_none? { |el| el < 3 }
      expect(flag).to eq(false)
    end
  end

  describe '#my_count' do
    it 'checks how many elements there are in total.' do
      number = enumerable.my_count
      expect(number).to eq(3)
    end

    it 'checks how many elements there are that are greater than 1.' do
      number = enumerable.my_count { |el| el > 1 }
      expect(number).to eq(2)
    end

    it 'checks how many elements there are that are equal to 3.' do
      number = enumerable2.my_count { |el| el == 3 }
      expect(number).to eq(1)
    end

    it 'checks how many elements there are that are divisible by 2.' do
      number = enumerable2.my_count(&:even?)
      expect(number).to eq(1)
    end
  end

  describe '#my_inject' do
    it 'returns the accumulated sum of all elements' do
      number = enumerable.inject(:+)
      expect(number).to eq(6)
    end

    it 'returns the accumulated sum of all elements' do
      number = enumerable.my_inject { |sum, value| sum + value }
      expect(number).to eq(6)
    end

    it 'returns the accumulated sum of all elements, with five as the base value' do
      number = enumerable.my_inject(5) { |sum, value| sum + value }
      expect(number).to eq(11)
    end

    it 'returns the accumulated product of all elements, with two as the base value' do
      number = enumerable2.my_inject(3) { |product, value| product * value }
      expect(number).to eq(18)
    end
  end
end
