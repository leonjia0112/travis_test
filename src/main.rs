fn main() {
    use std::fs::File;

    let f = match File::open("panic-test.sh") {
        Ok(f) => f,
        Err(e) => {
            eprintln!("errro {}", e);
            return;
        }
    };
}

fn echo(s: &str) {
    println!("{}", s);
}

// Unit Testing
#[cfg(test)]
mod tests {
    fn test1() {
        use std::fs::File;
        let f = File::open("panic-test.sh").unwrap();
        assert!(true);
    }
}
