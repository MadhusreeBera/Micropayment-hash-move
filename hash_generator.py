import hashlib
import secrets

def generate_random_seed(length=16):
    characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    return ''.join(secrets.choice(characters) for _ in range(length))

# def hash_seed_ten_times(seed):
#     # Convert the seed to bytes
#     seed_bytes = seed.encode('utf-8')

#     # Initial hash
#     hash_value = hashlib.sha3_256(seed_bytes).hexdigest()

#     # Perform hashing 10 times
#     for _ in range(1, 11):
#         hash_value = hashlib.sha3_256(bytes.fromhex(hash_value)).hexdigest()
#         print(f"Hash {_}: {hash_value}")

#     return hash_value

# # Example usage
# seed = generate_random_seed()
# print(f"Generated Seed: {seed}")

# hash_value = hash_seed_ten_times('seed')
# # print(f"Hash of {seed} hashed 10 times using Keccak256: {hash_value}")


from eth_hash.auto import keccak

def keccak256_hash(data):
    return keccak(data).hex()

def hash_seed_ten_times(seed):
    # Convert the seed to bytes
    seed_bytes = seed.encode('utf-8')

    # Initial hash
    hash_value = keccak256_hash(seed_bytes)

    # Perform hashing 10 times
    for _ in range(1, 11):
        hash_value = keccak256_hash(bytes.fromhex(hash_value))
        print(f"Hash {_}: {hash_value}")

    return hash_value

# Example usage
seed = generate_random_seed()
print(f"Generated Seed: {seed}")

hash_value = hash_seed_ten_times(seed)
# print(f"Hash of {seed} hashed 10 times using Keccak256: {hash_value}")

