list_concat = fn a, b -> a ++ b end

sum = fn a, b, c -> a + b + c end

pair_tuple_to_list = fn {a, b} -> [a, b] end

fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

fizz_buzz_rem = fn n -> fizz_buzz.(rem(n, 3), rem(n, 5), n) end

result = for n <- 10..16, do: fizz_buzz_rem.(n)

prefix = fn p -> fn s -> "#{p} #{s}" end end
