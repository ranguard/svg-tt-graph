use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'         => 'Task::SDK',
    'VERSION_FROM' => 'lib/Task/SDK.pm',
    'PREREQ_PM'    => {
        'Test::More' => 0.1,
    },
);
