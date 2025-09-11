# receipts\_api

**Public Repository – Developed by William Pérez Beltrán**

`receipts_api` is a Ruby on Rails API application for managing receipts, payments, and photos. The API includes OCR text extraction functionality and integrates with Tesseract OCR for text recognition from images.

## Features

* Create and manage receipts with associated payments and photos
* Text extraction using **Tesseract OCR**
* PostgreSQL or SQLite support for development
* RESTful API endpoints for receipt management
* Example JSON responses in `json_examples`

## Ruby Version

* Ruby 3.x (as specified in `.ruby-version`)

## System Dependencies

* Rails 7.x
* Tesseract OCR (for text extraction)

### Installing Tesseract OCR

On Linux:

```bash
sudo apt-get install tesseract-ocr
```

On MacOS (with Homebrew):

```bash
brew install tesseract
```

## Configuration

* Configure database in `config/database.yml`
* Supports PostgreSQL for production and SQLite for development

## Database Setup

```bash
rails db:create
rails db:migrate
rails db:seed # optional
```

## Running the Test Suite

```bash
rspec
# or
rails test
```

## Running the API Server

```bash
rails server
```

The API will be available at `http://localhost:3000`

## Services

* Tesseract OCR for text extraction
* Rails ActiveJob (optional) for background tasks

## Deployment Instructions

* Make sure PostgreSQL is installed on the production server
* Set environment variables for database credentials
* Precompile assets if needed:

```bash
rails assets:precompile
```

* Start the server using `rails server` or a web server like Puma or Passenger

## Author

**William Pérez Beltrán**
