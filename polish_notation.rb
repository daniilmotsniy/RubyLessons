class PolishNotationConvertor
  def initialize
    @operators = []
    @operands = []
    @to_merge = false
    @trigonometric = ""
  end
  
  TRIGONOMETRICAL_LIST = %w[cos sin tan cot]

  Operator = Struct.new(:operand1, :operand2, :operator) do
    def concat
      if operator.strip == '^' || operator.strip == '/'
        return '(' + [operator, operand2, operand1].join('') + ')'
      end
      '(' + [operator, operand1, operand2].join('') + ')'
    end
  end
  
  def convert_to_polish_notation(str)
    initialize
    str.split(//).reject { |x| x == " " }.each { |symbol|
      case
      when symbol == "("
        open_bracket_calc symbol
      when symbol == ")"
        closed_bracket_calc
      when !operator?(symbol)
        digit_calc symbol
      else
        if trigonometric?(symbol)
          @trigonometric << symbol; next
        end
        operand_calc symbol
      end
    }
    results_calc
    @operands.last
  end

  def get_full_result(str)
    repl = { '(' => '', ')' => '' }.tap { |h| h.default_proc = ->(h, k) { k } }

    stack = []
    str.gsub(/./, repl).split(" ").reverse.each { |symbol|
      if digit?(symbol)
        stack.push(symbol.to_f)
      else
        operand1 = stack.pop.to_f
        if TRIGONOMETRICAL_LIST.include? symbol
          stack.push(trigonometrical_calc symbol, operand1); next
        end

        operand2 = stack.pop.to_f
        if symbol == '^'
          stack.push(operand1 ** operand2); next
        end

        if  %w[+ / * -].include? symbol
          stack.push(operand1.public_send(symbol, operand2)); next
        end
      end
    }
    stack.pop
  end

  def operator?(str)
    !digit? str
  end

  def digit?(str)
    str.match?(/\d/)
  end

  def trigonometric?(str)
    TRIGONOMETRICAL_LIST.join.chars.uniq.include? str
  end

  def open_bracket_calc(symbol)
    @operators << @trigonometric + " " unless @trigonometric.empty?
    @operators << symbol
    @trigonometric = ""
    @to_merge = false
  end

  def closed_bracket_calc
    while @operators.length != 0 && @operators.last != "(" do
      expression_calc
    end
    @operators.pop
    @to_merge = false
  end

  def expression_calc
    node = Operator.new(@operands.pop, @operands.pop, @operators.pop)
    @operands.push(node.concat)
  end

  def digit_calc(symbol)
    @operands << @operands.pop.strip + symbol + " " if @to_merge
    @operands << symbol + " " unless @to_merge
    @to_merge = true
  end

  def get_priority(str)
    if str == "-" || str == "+"
      return 1
    end
    if str == "*" || str == "/"
      return 2
    end
    if str == "^"
      return 3
    end
    if TRIGONOMETRICAL_LIST.include? str
      return 4
    end
    0
  end

  def operand_calc(symbol)
    while @operators.length != 0 && get_priority(symbol.to_s) <= get_priority(@operators.last&.strip) do
      expression_calc
    end
    @operators.push(symbol + " ")
    @to_merge = false
  end

  def results_calc
    while @operators.length != 0 do
      node = Operator.new(@operands.pop, @operands.pop, @operators.pop)
      @operands.push(node.concat)
    end
  end

  def trigonometrical_calc(symbol, operand1)
    if symbol == 'cot'
      1 / Math.tan(operand1)
    else
      Math.public_send(symbol, operand1)
    end
  end
end


convertor = PolishNotationConvertor.new
input = gets.chomp
converted = convertor.convert_to_polish_notation input
puts converted + ", result: " + "#{convertor.get_full_result converted}\n\n"
