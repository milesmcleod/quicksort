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
    return if length <= 1
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    # debugger
    prc ||= Proc.new { |x, y| x > y ? 1 : -1 }
    pivot_el_idx = start
    idx = start + 1
    while idx < start + length
      if prc.call(array[pivot_el_idx], array[idx]) == 1
        array[pivot_el_idx + 1], array[idx] = array[idx], array[pivot_el_idx + 1]
        array[pivot_el_idx], array[pivot_el_idx + 1] = array[pivot_el_idx + 1], array[pivot_el_idx]
        pivot_el_idx = pivot_el_idx + 1
      end
      idx += 1
    end
    pivot_el_idx
  end
end
