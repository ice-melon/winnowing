#winnowing: compare two files similarity
def fingerprint(path,k,b,window)
	f = File.new(path)
	s=''
	hash_array = Array.new() 
	f.each_char {|c|
		if c != ' ' && c != '	' && c!="\r" && c!="\n"
			s = s + c
		end	
	}
	h1 =  0
	i = 0
	while i < k
	 	h1= h1 + s[i]*b**(k-i)
	 	i= i+1
	 end 
	 hash_array <<  h1

	 j = 1
	 size = s.size
	 while j <= size - k 
	 	h = (hash_array[0] - s[j-1]*b**k + s[j+k-1] )*b
	 	hash_array << h
	 	j= j+1
	 end
	result = winnowing(hash_array,window)

end

def winnowing(array,window)
	pickset = Array.new
	i = 0
	size = array.size
	pick = -1
	hit = 0 
	while i <= size - window
		j = 1
		min = array[i]
		while j <  window
			if array[i + j] <= min
				min = array[i+j]
			end
			j = j + 1
		end
		j = 0
		while j < window
			if array[i+j] == min
				hit = i + j
			end
			j = j+1
		end
		if pick == -1 || pick < hit
			pick = hit
			pickset << array[pick]
		end
		i = i + 1		
	end
	return pickset
end

a = fingerprint('test1',5,2,4)
b =  fingerprint('test2',5,2,4)


def countsimilarity(file1,file2)
	a = fingerprint(file1,5,2,4)
	b =  fingerprint(file2,5,2,4)
	count = 0
	for element in a 
		same = false
		for temp in b
			if element == temp
				same  = true
			end
		end
		if same
			count = count + 1
		end
	end
	similarity = (count+ 0.0)/a.size
	puts similarity
end

#file2 over file1
countsimilarity('heap.rb','sort.rb')

