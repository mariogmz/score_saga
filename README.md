# score_saga

Score Saga is a Ruby on Rails backend for an existing mobile app. It enables users to log in, submit game completion data, and view summary statistics. The app provides a reliable API for user authentication, game data handling, and performance metrics, ensuring a smooth and engaging experience for gamers.

## Prerequisites

- Ruby 3.3.4
- Rails 7.1
- Postgresql 16
- Docker
- Rails Master Key

## Run the project locally

```bash
# Inside the project's root dir
$ bundle install
$ bin/rails db:create db:migrate
$ bin/rails server
```

This will run in `localhost:3000`, you can use postman or curl to test this JSON Api.

## Endpoints

```bash
                                  Prefix Verb   URI Pattern                                                                                       Controller#Action
                            user_session POST   /api/sessions(.:format)                                                                           users/sessions#create {:format=>:json}
                    destroy_user_session DELETE /api/sessions(.:format)                                                                           users/sessions#destroy {:format=>:json}
                cancel_user_registration GET    /api/user/cancel(.:format)                                                                        users/registrations#cancel {:format=>:json}
                       user_registration DELETE /api/user(.:format)                                                                               users/registrations#destroy {:format=>:json}
                                         POST   /api/user(.:format)                                                                               users/registrations#create {:format=>:json}
                         api_game_events GET    /api/user/game_events(.:format)                                                                   api/game_events#index {:format=>:json}
                                         POST   /api/user/game_events(.:format)                                                                   api/game_events#create {:format=>:json}
```

Relevant endpoints for this stage:

- `POST /api/user` Sign up, receives `{ user: {email: string, password: string } }`
- `POST /api/sessions` Logs in

```json
{
    "data": {
        "token": "JWT token here",
        "user": {
            "id": 1,
            "email": "test@dev.com",
            "member_since": "2024-08-04T00:25:50.809Z"
        }
    }
}
```
- `DELETE /api/sessions` Logs out
- `GET /api/user` Gets the current user's info and the total games played
- `POST /api/user/game_events` Allows registering new game events
- `GET /api/user/game_events` Gets the current user's list of games played

After login, add the `token` to the `Authentication` header of the consequent requests to prevent unauthorized responses, user info and user game events require authentication.

## Running the service on docker

This needs to have all proper envs in the `.env` file, an example is provided in this repo, then:

```bash
$ docker build -t app .
$ docker volume create app-storage
$ docker run --rm -it -v app-storage:/rails/storage -p 3000:3000 --env-file .env app
```

## Development

This project uses rubocop to lint all the Ruby files, you can run `bundle exec rubocop -A` to automatically fix all the offenses.

## Running tests

Tests for this project are using RSpec, so:

```bash
$ bin/rails db:test:prepare # Only first time, or RAILS_ENV=test bin/rails db:
$ bundle exec rspec --format documentation
```

Coverage is stored in `/coverage` folder, after running rspec: `open coverage/index.html` will show the coverage report.

## Want to see it live?

It's currently deployed on a public EC2 instance: http://54.236.8.27:3000/

Example:
```bash
curl --location 'http://54.236.8.27:3000/api/user' \
--header 'Authorization: ---' \
--header 'Cookie: _interslice_session=GxfyIibYQuHapiXJD3jrriHckgjb6H1wDtKhA6nBxFqZd94SiX8Gmsc11p41gJ%2FbIT5v8glS6SE8ria9e2eVXeUfXqxXMmkOmGsJvWgbC31hmmTJ168cNKWVJybGTUahGntxRR70aji0EW6U12GWXJt5KaXK5RFPE1PotjkDdw53F%2BChWgVL1lmrGjBCCY5dAopDVY5gNsAH3Q24im4TZux3BQAhmz5GH6c3ZytcyTeObAe22ex7rqomLXO%2B%2BbCJjQnY3UezxTPm34wVJyEri6A9r5uVWSfIKVyf--PGl510JWKyElx0mF--NjMzHvEgpZqrArApoWN%2FGQ%3D%3D' \
--data ''
```

Response:
```json
{
    "user": {
        "id": 1,
        "email": "test@dev.com",
        "member_since": "2024-08-04T00:25:50.809Z",
        "stats": {
            "total_games_played": 0
        }
    }
}
```

### TODO

- Automate deploys with Kamal.
- Cleanup some unused routes.
- Add cache, there's a PR for that using `solid_cache`.