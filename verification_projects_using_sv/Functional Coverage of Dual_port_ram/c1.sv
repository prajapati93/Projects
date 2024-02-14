typedef struct {
  rand int id;
  rand string name;
  rand int score;
} student_t;

student_t students[];

constraint c1 { id inside {[1:100]}; }
constraint c2 { name.size() > 0; }
constraint c3 { score inside {[0:100]}; }

class student_factory;
  rand int num_students;
  constraint c_num_students { num_students > 0; }
  
  function void create_students();
    students = new[num_students];
    foreach (students[i]) begin
      students[i] = new();
      if (!students[i].randomize()) begin
        $error("Failed to randomize student %0d", i);
      end
    end
  endfunction
endclass

initial begin
  student_factory factory = new();
  factory.num_students = 5;
  factory.randomize() with { c_num_students; };
  
  $display("%-5s%-10s%-10s", "ID", "Name", "Score");
  foreach (students[i]) begin
    $display("%-5d%-10s%-10d", students[i].id, students[i].name, students[i].score);
  end
end