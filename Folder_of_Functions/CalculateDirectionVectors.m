function direction_vectors = CalculateDirectionVectors
[i, j, k] = ind2sub([3 3 3], 1 : 27);
direction_vectors = [i' - 2, j' - 2, k' - 2];
end