%% Variables
% Variables in MATLAB are defined by assigning a value to them.
a = 10;
b = 11;

% We can print the contents of a variable with the disp() function.
disp('Variable Contents');
disp(a);
disp(b); 
%%


% Reassigning a variable will change its value.
disp(' ');
disp('Reassigning Vaiables');
a = 5;
disp(a);
a = -2;
disp(a);
%%

% We can also assign the value of one variable to another.
disp(' ');
disp('Assining Variables to Others');
disp(a);
disp(b);
a = b;
disp(a);

%%

% We can also assign the result of a mathematical expression to a variable.
disp(' ');
disp('Mathematical Expressions');
a = 2*5;
disp(a);

a = b^2;
disp(a);

a = sqrt(19) - abs(5 + 2j);
disp(a);

%% Arrays
% Arrays in MATLAB are defined using square brackets.
disp(' ');
disp('Arrays');
an_array = [5, 4, 3, 2, 1];
disp(an_array);

% We can get a specific variable of an array using round brackets.
% The first element has index 1
disp(an_array(1));
disp(an_array(2));

% We can get the last element of an array using the end keyword.
disp(an_array(end));

% To generate sequential arrays we can use the : operator.
disp(' ');
disp('Generating Arrays');
another_array = 1:10; % this create an array with the values 1 to 10
disp(another_array);

% Using the start:step:end syntax we can define the step between elements.
another_array = 1:2:10;
disp(another_array);

%% Conditional Logic
% If statements allow us to do different things depending on the outcome
% of a conditional expression. In MATLAB if statements are written like
% this.
disp(' ');
disp('Conditional Logic');
a = randn(1);

if (a < 0) % If this test is true we run the statement after the if.
    disp('a is negative');
elseif (a == 0) % If the first test was false but this one is true we
                % run the statement under here. Note the use of == to 
                % test for equality, if you just use a single = it won't
                % work.
    disp('a is zero');
else % If all the above tests were false we run the contents of the else 
     % block.
    disp ('a is positive');
end

%% for Loops
disp(' ');
disp('for Loops');
%% 

% for loops in MATLAB look like this.
for i = 1:5
  disp(i) % this line is repeated for every value of i in the range 1 to 5.
end

disp(' ');

%%
% a for loop can iterate over any array you like
an_array = [1, 5, 3, 2, 5, 6];

for i = 1:length(an_array)
  disp(an_array(i));
end

disp(' ');

% or even more succinctly
for i = an_array
  disp(i);
end

%% Functions
disp(' ');
disp('Functions');
% Functions in MATLAB are defined in separte files.
% The a_function.m file defines a function called a_function.
% This function multiplies its input by 5.
a = a_function(10);
disp(a);