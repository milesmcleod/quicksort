require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    prc = Proc.new { |x, y| x > y ? 1 : -1 }
    return array if array.length <= 1
    pivot = array[0]
    left = []
    right = []
    array[1..-1].each do |el|
      if prc.call(pivot, el) == 1
        left.push(el)
      else
        right.push(el)
      end
    end
    QuickSort.sort1(left).concat([pivot]).concat(QuickSort.sort1(right))
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x > y ? 1 : -1 }
    return array if length <= 1
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, 0, pivot_idx, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x > y ? 1 : -1 }
    pivot_idx = start
    pivot = array[start]
    i = start + 1
    while i < start + length
      check = prc.call(pivot, array[i])
      if check == 1 && i != pivot_idx + 1
        array[i], array[pivot_idx + 1] = array[pivot_idx + 1], array[i]
        pivot_idx += 1
      elsif check == 1
        pivot_idx += 1
      end
      i += 1
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end
