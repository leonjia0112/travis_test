fn main() {
    use std::fs::File;

    let f = File::open("panic-test.sh").unwrap();

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
