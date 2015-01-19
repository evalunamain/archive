class Employee

  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end

end

class Manager < Employee

  attr_reader :employees

  def initialize(name, title, salary, employees, boss = nil)
    @employees = employees
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    salary_sub_employees * multiplier
  end

  def salary_sub_employees
    return 0 if self.employees.empty?

    salaries = 0

    self.employees.each do |employee|
      salaries += employee.salary
      if employee.class == Manager
        salaries += employee.salary_sub_employees
      end
    end

    salaries
  end

end
