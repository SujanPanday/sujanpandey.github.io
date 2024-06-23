$(document).ready(function() {
    $('#terminal').terminal(function(command) {
        if (command.toLowerCase() === 'help') {
            this.echo('Available commands:');
            this.echo('  about - Information about me');
            this.echo('  resume - View my resume');
        } else if (command.toLowerCase() === 'about') {
            this.echo('Hi, I am [Your Name], a [Your Profession].');
            this.echo('I love working on [Your Interests].');
        } else if (command.toLowerCase() === 'resume') {
            this.echo('Fetching resume...');
            this.echo('Resume details here...');
            // You can fetch and display your resume details here
        } else {
            this.echo('Unknown command. Type "help" for available commands.');
        }
    }, {
        greetings: 'Welcome to my personal terminal. Type "help" for available commands.',
        prompt: '> '
    });
});
