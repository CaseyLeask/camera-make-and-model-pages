# Camera Make and Model Pages

A small service for building camera make and model pages

## Installation

### Installing Ruby

I've specified Ruby 2.2.4 in the `.ruby-version`, but anything in the 2.2.x range should be fine.

There are many ways to install Ruby. Personally I recommend [rbenv](https://github.com/rbenv/rbenv#readme), but you can visit the [Installation page](https://www.ruby-lang.org/en/documentation/installation/) and choose a way that suits you.

### Installing Bundler

Once Ruby is installed, you'll need [Bundler](https://bundler.io/)

```
gem install bundler
```

### Project specific dependencies

```
./script/bootstrap
```

## Usage

```
./script/start ${API_URL} ${OUTPUT_DIRECTORY}
```

### Running tests

```
./script/test
```

### Running linting

```
./script/rubocop
```

## Design Decisions

### Architecture

The design of this system is largely based around the concept of 'Functional Core, Imperative Shell', from one of my favourite talks about software design, [Boundaries, by Gary Bernhardt](https://www.destroyallsoftware.com/talks/boundaries).

Ideally, the Imperative shell would only consist of the `runner`, but the `parser` and `writer` read and write files, and fetch websites.

### Language choice

I knew the program would consist mostly of handling command line arguments, parsing xml, generating html and writing files.

While Scala, Node.js, Java and other languages have strong library solutions to most of these tasks, I felt Ruby was the best all-rounder for this task.

### Library choices

For testing, while `Test::Unit` would have worked, I like using `describe`, `context` and `it` to save myself typing the same things repeatedly.

For linting, I've grown used to using `Rubocop` to keep the code style within a codebase consistent.

For XML parsing, `oga` works well and I didn't feel like putting you through the pain of installing `nokogiri`.

If I really needed features specific to `nokogiri`, I'd feel obliged to add the extra effort of adding a `Dockerfile` and `docker-compose.yml` file to the project. 

### Issues and shortcomings

I strongly feel the testing of this could be improved a lot. The problem is largely a result of using `@work` through the `page` classes.

The direct reliance on `oga` through the code really impacts the ability to unit test these classes.

Extracting every use of `.css('*')` and `.text` into a class/pattern that controls all interaction with `oga` would go a long way into improving this code.

To that point, I restricted all interaction with `oga` to `.css('*')` and `.text` to make this easy in the future.

Having the pages interact with simple data would make testing a breeze.

### Deploying
I haven't included deployment because the requirements made no mention of it, but I know RedBubble uses AWS, so I'll give details of what I've done for services similar to this in AWS.

```
Cloudformation -> ASG with application (min: 0, max: 1, desired: 0)
               -> Role (with autoscaling terminate-instance permission)
               -> ScheduledAction (start of batch job, desired: 1)
               -> ScheduledAction (timeout of batch job, desired: 0)
```

Using the AWS Metadata API to obtain the instance id, you can self terminate on job completion

```
$instance-id = $(curl http://169.254.169.254/latest/meta-data/instance-id)
aws autoscaling terminate-instance-in-auto-scaling-group
                --instance-id $instance-id
                --should-decrement-desired-capacity
```

[Recurrence](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-as-scheduledaction.html#cfn-as-scheduledaction-recurrence) supports cron syntax, which covers most scheduling requirements.